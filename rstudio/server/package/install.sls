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
    - names: {{ rstudio.server.pkg.deps|json }}
    - refresh: true
  cmd.run:
    - name: curl -Lo {{ rstudio.dir.tmp }}/rstudio-server-{{ rstudio.server.version }}-{{ rstudio.server.pkg.packageurl.suffix }} {{ rstudio.server.pkg.packageurl.source }} # noqa 204
    - unless: test -f {{ rstudio.dir.tmp }}/rstudio-server-{{ rstudio.server.version }}
    - require:
      - file: rstudio-server-package-install-pkg
      - pkg: rstudio-server-package-install-pkg
    - retry: {{ rstudio.retry_option }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
rstudio-server-package-app-install:
     {%- if 'source_hash' in rstudio.server.pkg.packageurl and rstudio.server.pkg.packageurl.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ rstudio.dir.tmp }}/rstudio-server-{{ rstudio.server.version }}-{{ rstudio.server.pkg.packageurl.suffix }} # noqa 204
    - file_hash: {{ rstudio.server.pkg.packageurl.source_hash }}
    - require:
      - cmd: rstudio-server-package-install-pkg
    - require_in:
      - pkg: rstudio-server-package-app-install
  file.absent:
    - name: {{ rstudio.dir.tmp }}/rstudio-server-{{ rstudio.server.version }}
    - onfail:
      - module: rstudio-server-package-app-install
     {%- endif %}
  pkg.installed:
    - sources:
      - rstudio-server: {{ rstudio.dir.tmp }}/rstudio-server-{{ rstudio.server.version }}-{{ rstudio.server.pkg.packageurl.suffix }} # noqa 204
    - skip_verify: true
    - refresh: true
    - reload_modules: true
    - onlyif:
      - {{ rstudio.server.pkg.use_upstream_packageurl }}
      - {{ grains.os_family in ('RedHat', 'Debian', 'Suse') }}
