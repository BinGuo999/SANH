# South Asian Nitrogen Hub (SANH) NEMO regional model

![Bathymetry for SANH domain](https://github.com/NOC-MSM/SANH/wiki/FIGURES/SANH_bathy.png)

Getting started
===============

**Clone** this repository onto your favourite linux box:

<pre>
  git clone git@github.com:NOC-MSM/SANH.git
</pre>

Access **JASMIN data**. For JASMIN file structure see wiki page: JASMIN_data_storage). On your favourite linux box::

<pre>
  exec ssh-agent $SHELL
  ssh-add ~/.ssh/id_rsa_jasmin
</pre>

On request enter passphrase for ``/login/$USER/.ssh/id_rsa_jasmin``. Hopefully this
is accepted. Then successively log into a login node. This can not see the SANH data::

<pre>
  ssh -A jelt@jasmin-login1.ceda.ac.uk
</pre>

From here you can hop to a compute node, which can see the SANH data::

<pre>
  ssh -A jelt@jasmin-sci1.ceda.ac.uk
  cd /gws/nopw/j04/campus/pseudoDropBox/BoBEAS
</pre>

File Hierarchy
==============

Each configuration directory should be laid out in the following manner, to
facilitate configuration archival and sharing:

<pre>
BoBEAS
|
|__ ARCH
|__ EXP_2016	
|__ EXP_Apr19
|__ MY_SRC
|__ SCRIPTS
|__ STARTFILES	
|
|__ .gitignore	
|__ README.md	
|__ cpp_file.fcm	
</pre>


