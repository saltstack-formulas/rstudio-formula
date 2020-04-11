# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}

rstudio-desktop-package-clean:
  pkg.removed:
    - names:
      - {{ rstudio.desktop.pkg.name }}
    - reload_modules: true
