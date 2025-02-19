# frozen_string_literal: true

class UrlsController < ApplicationController
  def encode
    url = Url.find_by(long_url: url_params)
    url = Url.create(long_url: url_params, identifier: IdentifierGenerator.generate_identifier) if url.blank?

    render json: { encoded_url: "#{request.base_url}/#{url.identifier}" }
  end

  def decode
    url = Url.find_by(identifier: params[:url])

    render json: { decoded_url: url.try(:long_url) }
  end

  def show
    url = Url.find_by!(identifier: params[:identifier])

    # use status 301 so that we don't have to handle the redirect everytime the same URL is accessed
    redirect_to url.long_url, allow_other_host: true, status: :moved_permanently
  end

  private

  def url_params
    params.require(:url)
  end
end
