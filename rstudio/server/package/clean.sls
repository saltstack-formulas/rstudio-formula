# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}

rstudio-server-package-clean:
  pkg.removed:
    - names:
      - {{ rstudio.server.pkg.name }}
    - reload_modules: true
