# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}
{%- set sls_package_clean = tplroot ~ '.server.package.clean' %}

include:
  - {{ sls_package_clean }}

rstudio-server-config-file-removed:
  file.absent:
    - names:
      - {{ rstudio.server.environ_file }}
    - require:
      - sls: {{ sls_package_clean }}
