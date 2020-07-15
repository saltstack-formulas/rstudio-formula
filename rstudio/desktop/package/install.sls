# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}

rstudio-desktop-package-install-pkg:
  file.directory:
    - name: {{ rstudio.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - names: {{ rstudio.desktop.pkg.deps|json }}
    - reload_modules: true
    - refresh: true
  cmd.run:
    - name: curl -Lo {{ rstudio.dir.tmp }}/rstudio-desktop-{{ rstudio.desktop.version }}-{{ rstudio.desktop.pkg.package.suffix }} {{ rstudio.desktop.pkg.package.source }}  # noqa 204
    - unless: test -f {{ rstudio.dir.tmp }}/rstudio-desktop-{{ rstudio.desktop.version }}
    - require:
      - file: rstudio-desktop-package-install-pkg
      - pkg: rstudio-desktop-package-install-pkg
    - retry: {{ rstudio.retry_option }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
rstudio-desktop-package-app-install:
     {%- if 'source_hash' in rstudio.desktop.pkg.package and rstudio.desktop.pkg.package.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ rstudio.dir.tmp }}/rstudio-desktop-{{ rstudio.desktop.version }}-{{ rstudio.desktop.pkg.package.suffix }}  # noqa 204
    - file_hash: {{ rstudio.desktop.pkg.package.source_hash }}
    - require:
      - cmd: rstudio-desktop-package-install-pkg
    - require_in:
      - pkg: rstudio-desktop-package-app-install
  file.absent:
    - name: {{ rstudio.dir.tmp }}/rstudio-desktop-{{ rstudio.desktop.version }}
    - onfail:
      - module: rstudio-desktop-package-app-install
     {%- endif %}
  pkg.installed:
    - sources:
      - {{ rstudio.desktop.pkg.name }}: {{ rstudio.dir.tmp }}/rstudio-desktop-{{ rstudio.desktop.version }}-{{ rstudio.desktop.pkg.package.suffix }}  # noqa 204
    - skip_verify: true
    - refresh: true
    - reload_modules: true
    - onlyif:
      - {{ rstudio.desktop.pkg.use_upstream_package }}
      - {{ grains.os_family in ('RedHat', 'Debian', 'Suse') }}
