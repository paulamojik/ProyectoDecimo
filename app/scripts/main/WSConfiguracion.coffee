angular.module('WissenSystem')


# Configuración principal de nuestra aplicación.
.config(['$cookiesProvider', '$stateProvider', '$urlRouterProvider', '$httpProvider', '$locationProvider', 'App', 'PERMISSIONS', 'RestangularProvider', '$intervalProvider', '$rootScopeProvider', 'USER_ROLES', 'toastrConfig', 'uiSelectConfig', ($cookies, $state, $urlRouter, $httpProvider, $locationProvider, App, PERMISSIONS, Restangular, $intervalProvider, $rootScopeProvider, USER_ROLES, toastrConfig, uiSelectConfig)->

	Restangular.setBaseUrl App.Server # Url a la que se harán todas las llamadas.


	uiSelectConfig.theme = 'select2'
	uiSelectConfig.resetSearchInput = true


	#- Definimos los estados
	$urlRouter.otherwise('/')

	$state
	.state('main', { #- Estado raiz que no necesita autenticación.
		url: '/'
		views: 
			'principal':
				templateUrl: App.views+'main/main.tpl.html'
				controller: 'MainCtrl'
		data: 
			pageTitle: 'En Construcción'
	})
	.state('login', { 
		url: '/login'
		views:
			'principal':
				templateUrl: "#{App.views}login/login.tpl.html"
				controller: 'LoginCtrl'
		data: 
			pageTitle: 'Ingresar a Wissen'

	})
	.state('logout', { 
		url: '/logout'
		views:
			'principal':
				templateUrl: "#{App.views}login/logout.tpl.html"
				controller: 'LogoutCtrl'
		data: 
			icon_fa: 'fa fa-user'

	})
	

	#$locationProvider.html5Mode true

	$rootScopeProvider.bigLoader = true

	# Agrego la función findByValues a loDash.
	_.mixin 
		'findByValues': (collection, property, values)->
			filtrado = _.filter collection, (item)->
				_.contains values, item[property]
			if filtrado.length == 0 then return false else filtrado[0]

	@
])

# Filtro para frases en Camellcase
.filter('capitalize', ()->
	(input, all)->
		return if !!input then input.replace(/([^\W_]+[^\s-]*) */g, (txt)-> txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()) else ''
)




