<h1 align="center">
  <a href="https://www.ampol.com.au/service-stations/ampol-app"><img src="https://firebasestorage.googleapis.com/v0/b/the-foodary-production.appspot.com/o/kinetic_ampol.png?alt=media&token=d496329d-40f2-4568-9004-dc3aa2b72df2" alt="Ampol" width="700"></a>
  <br/>
  Ampol Kinetic
  <br/>
</h1>

<h4 align="center">A pure <a href="https://developer.apple.com/xcode/swiftui/" target="_blank">SwiftUI</a> implementation for building Ampol mobile applications and delivering services to its customers.</h4>

<p align="center">
  <a href="#key-features">Key Features</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#installation">Installation</a> •
  <a href="#coverage">Coverage</a> •
  <a href="#team">Team</a> •
  <a href="#quicklinks">Quick Links</a>
</p>

[![Coverage](https://codecov.io/bb/caltexcooper/kinetic-ios/branch/master/graph/badge.svg?token=M9MXEB8D03)](https://codecov.io/bb/caltexcooper/kinetic-ios)

![screenshot](https://firebasestorage.googleapis.com/v0/b/the-foodary-production.appspot.com/o/ampol_app_store.png?alt=media&token=cf379bb2-668a-41f1-b4a2-bcb57db5d5b8)

## Key Features

* Vanilla SwiftUI Implementation:
    * Combine for observer and publisher chains.
    * Combine for network and repository layer.
* Injection - Dependency injection using a SwiftUI `EnvironmentValues` like implementation for native first party support:
    * Allows for ease of mocking and inversion of control within the application.
    * Provides compile time safe registration of dependencies. (If the project builds! All dependencies have been registered correctly.)
    * Dependency provision by abstraction, allowing for dependencies to be injected by their abstract (protocol or superclass) types.
    * Property wrappers for injectables as well as support for injecting observable types similar to SwiftUI's concrete implementation of `@ObservedObject`
* Theming:
    * Theme injection through view heirarchy to provide developers with the necessary values and styles for use in their SwiftUI views.
    * No need for hard coding any values, the following are supported by the Combustion design system:
        * Colors
        * Spacing (Internal)
        * Spacing (Margins/External)
        * Motion (Animations and delays)
        * Shapes (Defenitions for backgrounds and materials)
    * Automatic switching of dark and light mode with support for user customization.
* ELMs (MVU/Stores/State/Unidirectional data flow) inspired architecture with clean separation of concerns:
    * Decoupled **presentation**, **business logic** and **data access** layers.
    * Provides `functional immutibility` of values and state for high cohesion and state safety.
    * State updates automatically cause view recomposition of relevant consumers through the `@Published` and `@InjectObservable` wrappers.
        * Views are functions of state within the application, leading to highly performant and predictable UI.
    * Side-effects are controlled and isolated to interactors/interactions.
        * `Side-effects` only produce updates to state publishers and do not mutate data, instead publsish new `Value-Type` states.
    * Build with scalability and testibility in mind for iterating and delivering quickly.
    * Highly testable at both unit and integration level.
        * Testing using `XCTest + ViewInspector` (Unit testing SwiftUI views) and `XCUITest`
        * Highly modular for testing in isolation
        * First party network mocking through URLProtocol injection and compile time safe mocked responses.


## Architecture

```mermaid
graph RL
    V([View])
    U((Store))
    I[Interactor]
    S[Service]
    R[(Repository)]
    
    subgraph Presentation
        V
    end

    U -.->|Publishes| V
    V -->|Action| I

    subgraph Domain
        I -->|Updates| U
    end

    subgraph Model
        S -->|Requests| R
        R -.->|Publishes| S
    end

    I -->|Action| S
    S -.->|Publishes| I
```
*(Requires MermaidJS browser plugin)*

## Installation

To clone and run this application, you will need the following: 

* Git: https://git-scm.com
* Xcode: https://developer.apple.com/xcode/
* Homebrew: https://brew.sh/
* SwiftLint: https://realm.github.io/SwiftLint/ - SwiftLint is required as an external dependency on your computer as it is not included as a Pod or Mint.

From your command line run the following:

```bash
# Clone this repository
$ git clone https://bitbucket.org/caltexcooper/kinetic-ios/src/master/

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/homebrew/install/HEAD/install.sh)"

# Install SwiftLint
$ brew install swiftlint
```

## Coverage
**App:** [![App Coverage](https://codecov.io/bb/caltexcooper/kinetic-ios/branch/master/graph/badge.svg?token=M9MXEB8D03&flag=app)](https://codecov.io/bb/caltexcooper/kinetic-ios)<br/>
**KineticAuthKit:** [![Modules Coverage](https://codecov.io/bb/caltexcooper/kinetic-ios/branch/master/graph/badge.svg?token=M9MXEB8D03&flag=KineticAuthKit)](https://codecov.io/bb/caltexcooper/kinetic-ios)<br/>
**KineticCore:** [![Modules Coverage](https://codecov.io/bb/caltexcooper/kinetic-ios/branch/master/graph/badge.svg?token=M9MXEB8D03&flag=KineticCore)](https://codecov.io/bb/caltexcooper/kinetic-ios)<br/>
**KineticAPI:** [![Modules Coverage](https://codecov.io/bb/caltexcooper/kinetic-ios/branch/master/graph/badge.svg?token=M9MXEB8D03&flag=KineticAPI)](https://codecov.io/bb/caltexcooper/kinetic-ios)<br/>
**KineticInjection:** [![Modules Coverage](https://codecov.io/bb/caltexcooper/kinetic-ios/branch/master/graph/badge.svg?token=M9MXEB8D03&flag=KineticInjection)](https://codecov.io/bb/caltexcooper/kinetic-ios)<br/>

[![Coverage grid](https://codecov.io/bb/caltexcooper/kinetic-ios/branch/master/graphs/tree.svg?token=M9MXEB8D03)](https://codecov.io/bb/caltexcooper/kinetic-ios)
[![Coverage sunburst](https://codecov.io/bb/caltexcooper/kinetic-ios/branch/master/graphs/sunburst.svg?token=M9MXEB8D03)](https://codecov.io/bb/caltexcooper/kinetic-ios)

## Team

## Quick Links

