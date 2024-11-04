# Mock for bcryptprimitives.dll

This creates a placeholder `bcryptprimitives.dll` file which can be used with Wine if when running your Windows program you encounter this error:

```
0054:err:module:import_dll Library bcryptprimitives.dll (which is needed by L"Z:\\myapp.exe") not found
0054:err:module:LdrInitializeThunk Importing dlls for L"Z:\\myapp.exe" failed, status c0000135
```

Note that this DLL is a mock/dummy/placeholder and does not contain any actual functionality.

## Installation

Download the `bcryptprimitives.dll` from "Releases" page, extract and place this file either in the same directory as your program, or to `$WINEPREFIX/drive_c/windows/system32/`.

## Build from sources

In order to build the DLL from source you will need MinGW GCC toolchain. Set variable `$CC` to the path to `gcc` executable from the MinGW GCC toolchain and run `make`.


## Build from sources in Docker

For convenience, this repo contains a `Dockerfile` pre-configured with MinGW GCC, and a `build` script, which builds the docker image and runs the DLL build in it. Simply run `./build`.
