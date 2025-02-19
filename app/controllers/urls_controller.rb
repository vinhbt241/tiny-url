# frozen_string_literal: true

class UrlsController < ApplicationController
  def encode
    url = Url.find_or_create_by(long_url: url_params)

    render json: { encoded_url: url.short_url }
  end

  def decode
    url = Url.find_by(short_url: params[:url])

    render json: { decoded_url: url.try(:long_url) }
  end

  def url_params
    params.require(:url)
  end
end
