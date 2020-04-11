# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}

rstudio-desktop-package-install:
  pkg.installed:
    - sources:
      - rstudio: {{ rstudio.desktop.pkg.directurl.source }}
    - skip_verify: true
    - reload_modules: true
    - onlyif:
      - {{ rstudio.desktop.pkg.use_upstream_package_directurl }}
      - {{ grains.os_family in ('RedHat', 'Debian', 'Suse') }}
