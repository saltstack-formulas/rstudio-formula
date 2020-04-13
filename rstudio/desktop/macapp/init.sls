# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

include:
  - .install

    {%- else %}

rstudio-desktop-macos-init-unapplicable:
  test.show_notification:
    - text: |
        The rstudio desktop macpackage is only applicable on MacOS

    {%- endif %}
