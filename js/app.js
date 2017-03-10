/**
* @file app.js
* @brief APP
* @author JONATA CARDOSO DE SOUZA
* @date 10/03/2017
* @version 1.0
*/
(function () {
	angular.module(
		'task',[
		'ui.router',
		'oc.lazyLoad',
		'ngIdle',
		'base64'
		]
		).run(function($rootScope, $base64) {
			$rootScope.$base64 = $base64;
		});
	})();
