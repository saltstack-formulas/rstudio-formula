# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}

rstudio-desktop-macos-app-install-download:
  file.directory:
    - name: {{ rstudio.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo {{ rstudio.dir.tmp }}/rstudio-desktop-{{ rstudio.desktop.version }} {{ rstudio.desktop.pkg.macapp.source }}
    - unless: test -f {{ rstudio.dir.tmp }}/rstudio-desktop-{{ rstudio.desktop.version }}
    - require:
      - file: rstudio-desktop-macos-app-install-download
      - pkg: rstudio-desktop-macos-app-install-download
    - retry: {{ rstudio.retry_option }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
rstudio-desktop-macos-app-install:
  module.run:
    - onlyif: {{ rstudio.desktop.pkg.macapp.source_hash != None }}
    - name: file.check_hash
    - path: {{ rstudio.dir.tmp }}/rstudio-desktop-{{ rstudio.desktop.version }}
    - file_hash: {{ rstudio.desktop.pkg.macapp.source_hash }}
    - require:
      - cmd: rstudio-desktop-macos-app-install-download
    - require_in:
      - macpackage: rstudio-desktop-macos-app-install
  file.absent:
    - name: {{ rstudio.dir.tmp }}/rstudio-desktop-{{ rstudio.desktop.version }}
    - onfail:
      - module: rstudio-desktop-macos-app-install
  macpackage.installed:
    - name: {{ rstudio.dir.tmp }}/rstudio-desktop-{{ rstudio.desktop.version }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: rstudio-desktop-macos-app-install-download

    {%- else %}

rstudio-desktop-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The rstudio.desktop macpackage is only available on MacOS

    {%- endif %}
