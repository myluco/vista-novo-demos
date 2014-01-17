################################################################################
#
# Application Controller
#
# Copyright (c) 2014 The MITRE Corporation.  
# All rights reserved.
#
################################################################################

class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  MILLISECONDS_PER_SECOND = 1000
  
end
