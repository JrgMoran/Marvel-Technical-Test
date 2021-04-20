# Marvel-Technical-Test

Aplicación simple que explota la api de Marvel para listar todos los personajes.

## Requisitos
- iOS 13.2+
- Swift 5.0
- Xcode 12.2+
- ResourciOS (ya incluido). Más información en: https://github.com/JrgMoran/ResourciOS

## Instalación
Clona el repositorio y ejecuta en la terminal:
```
$ pod install
```

## Observaciones
La aplicación se basa en una arquitectura MVVM (Model-View-ViewModel) con RXSwift. En el proyecto se diferencian varios actores que son:

### View
La vista representa la parte visible de la aplicacion. Esto son los botones y demás elementos que el usuario ve. Esta compuesto del ViewController y de su archivo .xib. El ViewController tendra un objeto de viewModel donde pasará las acciones del usuario y este quedará a la espera de los datos del viewmodel


### ViewModel
Esta capa se encarga de la lógica de negocio de cada pantalla. Para ello, primero define en dos `Struct` la entrada de acciones a observar por el viewModel `Input` y de las acciones que debe observar el viewController `Output`

```
struct Input {
    let trigger: Observable<Void>
    let indexTap: Observable<Int>
}

struct Output {
    let characters: Observable<[Character]>
}
```

 El viewModel tiene el método `transform(input: Input) -> Output` que recibe esas acciones a observar de la vista y devuelve las acciones que la vista debe observar del ViewModel.
 
Al margen de recibir las acciones del usuario procedente de la vista también es el encargado de comunicarse con el `Router` y con los `UseCases` correspondientes para obtener los datos.
 
 
 ### Router
Es el encargado de la navegación entre pantallas. Sirve  tanto para navegar a otras pantallas como para autopresentarse el módulo.
También configura correctamente los objetos con Swinject.

```
class HomeRouter: Router {
    
    @discardableResult
    override init() {
        super.init()
        let viewController = HomeViewController()
        viewController.viewModel = injector.container.resolve(HomeViewModel.self, argument: self)
        navigate(to: viewController, mode: .new)
    }
    
    func navigateToDetail(of character: Character) {
        CharacterDetailRouter(with: character)
    }
}
```

### UseCases
Pequeñas clases pensadas para la obtención de un dato. Estas llaman a los Repositorios.


### Repository
Clase que se encarga de decidir como se trabajan con los datos. Elije si estos datos deben salir de Red, Cache, BBDD, Local...

### Client
Cada una de las clases de esta parte, se encarga de trabajar con el dato en su medio. Asi pués la clase NetworkClient es el encargado de trabajar con los datos en red.
