module.exports =

	mongoUrl: process.env.MONGO_URL or "mongodb://localhost/<%= name %>"
	sessionSecret: process.env.SESSION_SECRET or "9a205fba94b140e59456d3a5128075bd"
	port: process.env.PORT or 3000

	googleAppId: process.env.GOOGLE_APP_ID or "142221977275.apps.googleusercontent.com"
	googleAppSecret: process.env.GOOGLE_APP_SECRET or "l71TyRfcT4YRYXDAFYrm6itV"
	googleRedirectRoute: "/7c122160702e43b2970add96266e8313"
	googleAppRedirect: process.env.GOOGLE_APP_REDIRECT or "http://localhost:3000/7c122160702e43b2970add96266e8313"
