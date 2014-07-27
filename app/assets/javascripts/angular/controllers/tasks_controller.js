(function () {
  var app = angular.module('taskRepository', []);

  app.controller('TasksController', function ($scope, $http) {
    $scope.tasks = {};
    $scope.filter = '-created_at';

    $scope.getTasks = function () {
      $http.get('/api/tasks').success(function (data) {
        $scope.tasks = data;
      });
    };

    $scope.submitTask = function () {
      data = $scope.task;
      $http.post("/api/tasks?name=" + data.name + "&description=" + data.description).success(function (response) {
        $scope.tasks.push(response);
        $scope.reset()
      });
    };

    $scope.reset = function () {
      $scope.task = {};
    };

  });
})();