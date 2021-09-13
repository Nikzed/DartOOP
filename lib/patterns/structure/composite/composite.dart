abstract class Component {
  String operation();
  Component();
  void add(Component component) => throw UnimplementedError();
  void remove(Component component) => throw UnimplementedError();
  bool isComposite() => true;
}

class Leaf extends Component {
  @override
  String operation() {
    return 'Leaf';
  }

  @override
  bool isComposite() {
    return false;
  }
}

class Composite extends Component {
  List<Component> _children = [];

  @override
  void add(Component component) {
    _children.add(component);
  }

  @override
  void remove(Component component) {
    _children.remove(component);
  }

  @override
  String operation() {
    int i = 0;
    String result = 'Branch(';

    for (Component c in _children) {
      result += c.operation();
      if (i != _children.length - 1) {
        result += '+';
      }
      i++;
    }

    return result + ')';
  }
}

class Client {
  void clientCode(Component leaf) {
    print('result: ${leaf.operation()}\n');
  }

  void clientCode2(Component component1, Component component2) {
    if (component1.isComposite()) {
      component1.add(component2);
    }

    print('result: ${component1.operation()}\n');
  }
}

void main() {
  Client client = Client();

  Leaf leaf = Leaf();
  print('Client: simple component:');
  client.clientCode(leaf);

  // ...as well as the complex composites.
  Composite tree = Composite();
  Composite branch1 = Composite();
  branch1..add(Leaf())..add(Leaf());
  Composite branch2 = Composite();
  branch2.add(Leaf());
  tree.add(branch1);
  tree.add(branch2);
  print('Client: composite tree:');
  client.clientCode(tree);

  print(
      'Client: No need to check the components classes even when managing the tree:');
  client.clientCode2(tree, leaf);
}
