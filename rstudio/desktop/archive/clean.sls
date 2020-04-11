# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}

rstudio-desktop-package-archive-clean:
  file.absent:
    - names:
      - {{ rstudio.desktop.pkg.archive.name }}
      - {{ rstudio.desktop.dir.tmp }}
