(function () {
  var app = angular.module('taskRepository', []);

  app.controller('TasksController', function ($scope, $http) {
    $scope.tasks = [];
    $scope.filter = '-updated_at';
    $scope.errors = []

    $scope.getTasks = function () {
      $http.get('/api/tasks').success(function (data) {
        for (var i = 0; i < data.length; i++) {
          data[i].editMode = false;
        }
        $scope.tasks = data;
      });
    };

    $scope.submitTask = function () {
      data = $scope.task;
      console.log(data)
      if ($scope.valid()) {
        $http.post("/api/tasks?name=" + data.name + "&description=" + data.description).success(function (response) {
          $scope.tasks.push(response);
          $scope.reset()
        });
      }
    };

    $scope.reset = function () {
      $scope.task = {};
    };

    $scope.editTask = function (task) {
      data = angular.toJson(task);
      $http.put("/api/tasks/" + task.id, data).success(function (response) {
        task.updated_at = response.updated_at;
        task.editMode = false;
      });
    };

    $scope.deleteTask = function (task, $index) {
      $http.delete("/api/tasks/" + task.id).success(function (response) {
        $scope.tasks = $scope.tasks.filter(function (t) {
          return t.id != task.id;
        });
      });
    };

    $scope.valid = function () {
      $scope.descriptionErrorClass = ''
      $scope.nameErrorClass = ''
      $scope.errors = [];

      if ($scope.task) {
        var taskName = $scope.task.name;
        var taskDescription = $scope.task.description;

        if (taskName === "" || taskName.length < 5) {
          $scope.errors = $scope.errors.concat("Name must be longer than 5")
          $scope.nameErrorClass = 'ng-invalid'
        }

        if (taskDescription === "" || taskDescription.length < 15) {
          $scope.errors = $scope.errors.concat("Description must be longer than 15")
          $scope.descriptionErrorClass = 'ng-invalid'
        }

        if ($scope.errors.length > 0) {
          return false;
        } else {
          return true;
        }
      } else {
        $scope.errors.push("Please enter something")
        return false
      }
    }
  });
})();