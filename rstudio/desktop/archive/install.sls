# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

rstudio-desktop-package-archive-install:
  pkg.installed:
    - names: {{ rstudio.desktop.pkg.deps|json }}
  file.directory:
    - name: {{ rstudio.desktop.pkg.archive.name }}
    - user: {{ rstudio.rootuser }}
    - group: {{ rstudio.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - archive: rstudio-desktop-package-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(rstudio.desktop.pkg.archive) }}
    - retry: {{ rstudio.retry_option|json }}
    - user: {{ rstudio.rootuser }}
    - group: {{ rstudio.rootgroup }}
