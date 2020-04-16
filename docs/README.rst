.. _readme:

rstudio-formula
====================

Formula to manage RStudio on GNU/Linux (server/desktop) and MacOS (desktop).

The R language is available in 'rlang-formula'.


|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/rstudio-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/rstudio-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release


.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.  If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_. If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``, which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.  See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see :ref:`How to contribute <CONTRIBUTING>` for more details.

Available states
----------------

.. contents::
   :local:

``rstudio``
^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs from rstudio solution.


``rstudio.desktop``
^^^^^^^^^^^^^^^^^^^

This state will install rstudio desktop and configuration on MacOS and GNU/Linux.

``rstudio.desktop.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall rstudio desktop and configuration.

``rstudio.desktop.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install rstudio desktop package.

``rstudio.desktop.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall rstudio desktop package.

``rstudio.desktop.archive``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install rstudio desktop from archive.

``rstudio.desktop.archive.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall rstudio desktop directory.

``rstudio.desktop.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall rstudio desktop and configuration from MacOS and GNU/Linux.

``rstudio.server``
^^^^^^^^^^^^^^^^^^^^^^^

This state will install rstudio server on GNU/Linux.

``rstudio.server.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install rstudio server package.

``rstudio.server.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall the rstudio server package.

``rstudio.server.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall rstudio server from GNU/Linux.

``rstudio.clean``
^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This removes the rstudio solution on MacOS and GNU/Linux.


Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``rstudio`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

