class ApplicationController < ActionController::API
  require 'jwt'
  include JsonWebToken
end
