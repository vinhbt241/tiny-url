# frozen_string_literal: true

class UrlsController < ApplicationController
  def encode
    url = Url.find_by(long_url: url_params)
    url = Url.create(long_url: url_params, identifier: IdentifierGenerator.generate_identifier) if url.blank?

    render json: { encoded_url: url.identifier }
  end

  def decode
    url = Url.find_by(identifier: params[:url])

    render json: { decoded_url: url.try(:long_url) }
  end

  def url_params
    params.require(:url)
  end
end
