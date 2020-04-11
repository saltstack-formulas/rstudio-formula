# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}

rstudio-desktop-macos-app-clean-files:
  file.absent:
    - names:
      - {{ rstudio.desktop.dir.tmp }}
      - /Applications/RStudio.app

    {%- else %}

rstudio-desktop-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The rstudio desktop macpackage is only available on MacOS

    {%- endif %}
