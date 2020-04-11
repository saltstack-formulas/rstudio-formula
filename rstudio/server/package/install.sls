# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}

rstudio-server-package-install-pkg-installed:
  pkg.installed:
    - sources:
      - google-rstudio-server-stable: {{ rstudio.server.pkg.directurl.source }}
    - skip_verify: true
    - reload_modules: true
    - onlyif:
      - {{ rstudio.server.pkg.use_upstream_package_directurl }}
      - {{ grains.os_family in ('RedHat', 'Debian', 'Suse') }}
