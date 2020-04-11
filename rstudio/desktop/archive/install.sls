# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio-desktop with context %}
{%- from tplroot ~ "/macros.jinja" import format_kwargs with context %}

rstudio-desktop-package-archive-install-extract:
  pkg.installed:
    - names:
      - curl
      - tar
      - gzip
  file.directory:
    - name: {{ rstudio.desktop.pkg.archive.name }}
    - user: {{ rstudio.rootuser }}
    - group: {{ rstudio.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - archive: rstudio-desktop-package-archive-install-extract
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(rstudio.desktop.pkg.archive) }}
    - retry:
        attempts: 3
        until: True
        interval: 60
        splay: 10
    - user: {{ rstudio.rootuser }}
    - group: {{ rstudio.rootgroup }}
