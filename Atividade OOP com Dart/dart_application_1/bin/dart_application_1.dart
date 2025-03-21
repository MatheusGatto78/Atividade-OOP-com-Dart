class Task {
  int id;
  String nome;
  DateTime data;

  Task(this.id, this.nome, this.data);
}

class TaskPriority extends Task {
  Priority priority;

  TaskPriority(super.id, super.nome, super.data, this.priority);
}

enum Priority {
  alta,
  media,
  baixa,
}

class TaskDTO {
  int id;
  String name;
  Priority pr;
  DateTime data;

  TaskDTO(this.id, this.name, this.pr, this.data);
}

abstract class TaskRepository {
  Task add(TaskDTO dto);
  Task remove(int id);
  Task updata(int id);
  Task findById(int id);
  Task findByName(String name);
  List<Task> getAllTasks();
  List<Task> getTaskByPriority();
}

class TaskRepositoryFromList implements TaskRepository {
  List<TaskPriority> tasks = [];

  @override
  TaskPriority add(TaskDTO dto) {
    var task = TaskPriority(dto.id, dto.name, dto.data, dto.pr);
    tasks.add(task);
    return task;
  }

  @override
  TaskPriority remove(int id) {
    var task = tasks.firstWhere((t) => t.id == id);
    tasks.remove(task);
    return task;
  }

  @override
  TaskPriority updata(int id) {
    var task = tasks.firstWhere((t) => t.id == id);
    return task;
  }

  @override
  TaskPriority findById(int id) => tasks.firstWhere((t) => t.id == id);

  @override
  TaskPriority findByName(String name) => tasks.firstWhere((t) => t.nome == name);

  @override
  List<TaskPriority> getAllTasks() => tasks;

  @override
  List<TaskPriority> getTaskByPriority() {
    tasks.sort((a, b) => a.priority.index.compareTo(b.priority.index));
    return tasks;
  }
}

void main() {
  var repo = TaskRepositoryFromList();
  var task1 = TaskDTO(1, "Estudar Dart", Priority.alta, DateTime.now());
  var task2 = TaskDTO(2, "Praticar Flutter", Priority.media, DateTime.now());
  var task3 = TaskDTO(3, "Praticar HTML", Priority.baixa, DateTime.now());
  repo.add(task1);
  repo.add(task2);
  repo.add(task3);

  for (var t in repo.getAllTasks()) {
    print("ID: ${t.id}, Tarefa: ${t.nome}, Data: ${t.data}");
  }
}
