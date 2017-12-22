Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, '1391748680934247', '7cebc852c7be9d53aa986799d43693d3'
  provider :facebook, '1457111554405200', '7766795ca8fc90ceee582817d4134f72'
  provider :google_oauth2, '425165981077-jdm3a6g5507c59139tvhng7t82us9i2l.apps.googleusercontent.com', 'eyfQd1W9GynWND9gv8FHcBdb'
end