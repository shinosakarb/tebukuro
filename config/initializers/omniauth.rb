OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
    Rails.application.secrets.twitter_key,  Rails.application.secrets.twitter_secret
  provider :github,
    Rails.application.secrets.github_key,  Rails.application.secrets.github_secret,
    scope: "user:email"
  provider :facebook,
    Rails.application.secrets.facebook_key,  Rails.application.secrets.facebook_secret,
    scope: "email"
end
