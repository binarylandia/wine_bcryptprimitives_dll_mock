#include <windows.h>

BOOL ProcessPrng(_Out_ PBYTE pbData, SIZE_T cbData) {
  // Function body intentionally left empty
  return TRUE; // or FALSE depending on expected behavior
}

BOOL APIENTRY DllMain(HMODULE hModule,
                      DWORD ul_reason_for_call,
                      LPVOID lpReserved) {
  switch (ul_reason_for_call) {
    case DLL_PROCESS_ATTACH:
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
      break;
  }
  return TRUE;
}
