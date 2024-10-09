#!/bin/bash
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    
#%
#% DESCRIPTION
#%    This worklet will allow you to enforce the presence of the provided repository on the endpoint.
#%    
#% USAGE
#%    ./remediation.sh
#%
#%    Please specify if the worklet is intended to run on a apt or yum based endpoint in the "aptOrYum" variable on
#%    line 35 as well as the name of the repo in the "repo" variable on line 36
#%
#% EXAMPLES
#%	  ./remediation.sh
#%    
#================================================================
#- IMPLEMENTATION
#-    version         WF-501-add_repository (www.automox.com) 1.0
#-    author          Team Linux
#-
#================================================================
#  HISTORY
#     11/11/2021 : Team Linux : Script creation
#     ##/##/#### : ####: Validated and catalogued
# 
#================================================================
# END_OF_HEADER
#================================================================
# Set the following virable to "yum" for yum based systems or
# "apt" for apt-get based systems(this should)
aptOrYum="apt"
repo="ppa:ansible/ansible"
#################################################################
if [ "$aptOrYum" == "yum" ]
then
  if [ -e "/bin/yum-config-manager" ]
  then
  yum-config-manager --add-repo "$repo" 2>&1
  yum-config-manager --enable "$repo" 2>&1
  echo "Repo added."
  elif [ -e "/usr/bin/dnf" ]
  then
  dnf config-manager --add-repo "$repo" 2>&1
  echo "Repo Added."
  fi
elif [ "$aptOrYum" == "apt" ]
then
  add-apt-repository --yes --update "$repo" 2>&1
  echo "Repo added."
fi
