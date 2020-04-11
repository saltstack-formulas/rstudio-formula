# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}

rstudio-server-package-install-pkg:
  file.directory:
    - name: {{ rstudio.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - names: {{ rstudio.server.pkg.deps }}
  cmd.run:
    - name: curl -Lo {{ rstudio.dir.tmp }}/rstudio-server-{{ rstudio.server.version }} {{ rstudio.server.pkg.packageurl.source }}
    - unless: test -f {{ rstudio.dir.tmp }}/rstudio-server-{{ rstudio.server.version }}
    - require:
      - file: rstudio-server-package-install-pkg
      - pkg: rstudio-server-package-install-pkg
    - retry: {{ rstudio.retry_option }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
rstudio-server-package-app-install:
  module.run:
    - onlyif: {{ rstudio.server.pkg.packageurl.source_hash != None }}
    - name: file.check_hash
    - path: {{ rstudio.dir.tmp }}/rstudio-server-{{ rstudio.server.version }}
    - file_hash: {{ rstudio.server.pkg.packageurl.source_hash }}
    - require:
      - cmd: rstudio-server-package-install-pkg
    - require_in:
      - pkg: rstudio-server-package-app-install
  file.absent:
    - name: {{ rstudio.dir.tmp }}/rstudio-server-{{ rstudio.server.version }}
    - onfail:
      - module: rstudio-server-package-app-install
  pkg.installed:
    - sources:
      - {{ rstudio.server.pkg.name }}: {{ rstudio.dir.tmp }}/rstudio-server-{{ rstudio.server.version }}
    - skip_verify: true
    - reload_modules: true
    - onlyif:
      - {{ rstudio.server.pkg.use_upstream_packageurl }}
      - {{ grains.os_family in ('RedHat', 'Debian', 'Suse') }}
