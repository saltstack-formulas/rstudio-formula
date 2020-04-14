# -*- coding: utf-8 -*-
# vim: ft=sls

include:
             {%- if grains.os_family in ('MacOS',) %}
  - .desktop.clean
             {%- else %}
  - .server.clean
  - .desktop.clean
             {%- endif %}
