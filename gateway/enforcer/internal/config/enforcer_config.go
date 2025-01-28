/*
 *  Copyright (c) 2025, WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */
 
package config

import (
	"github.com/wso2/apk/gateway/enforcer/internal/dto"
	config_from_adapter "github.com/wso2/apk/adapter/pkg/discovery/api/wso2/discovery/config/enforcer"
)

// EnforcerConfig is a struct that holds the enforcer configuration.
type EnforcerConfig struct {
	JWTConfiguration *dto.JWTConfiguration
	Analytics                     *config_from_adapter.Analytics
}