//
//  UnityBridge.h
//  iosApp
//
//  Created by Tony Ayman on 17.04.25.
//  Copyright © 2025 orgName. All rights reserved.
//


#ifdef __cplusplus
extern "C" {
#endif

void UnitySendMessage(const char* obj, const char* method, const char* msg);

#ifdef __cplusplus
}
#endif

