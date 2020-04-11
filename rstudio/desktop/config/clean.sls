# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}
{%- set sls_package_clean = tplroot ~ '.desktop.package.clean' %}

include:
  - {{ sls_package_clean }}

rstudio-desktop-config-file-removed:
  file.absent:
    - names:
      - {{ rstudio.desktop.environ_file }}
    - require:
      - sls: {{ sls_package_clean }}
