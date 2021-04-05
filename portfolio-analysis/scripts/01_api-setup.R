library('rameritrade')

CallbackURL = 'https://collinsapp'
ConsumerKey = 'QGAPWA...'

# Use the td_auth_loginURL to generate a URL to grant the app access 
td_auth_loginURL(ConsumerKey,CallbackURL)


# Enter the authorization code with '' as shown below
AuthCode = 'https://collinsapp/?code=QyxN2t...'

# Generate a Refresh Token. 
RefreshToken = td_auth_refreshToken(ConsumerKey, CallbackURL, AuthCode)

# The Refresh Token lasts for 90 days so should be saved to reference later, but this is not critical
# This will save the token to the current working directory
saveRDS(RefreshToken,'TDRefToken.rds')
getwd() # will show where the token has been saved
