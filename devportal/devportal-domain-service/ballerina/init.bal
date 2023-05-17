//
// Copyright (c) 2022, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import ballerina/log;
import ballerinax/postgresql;
import ballerina/sql;
import ballerina/http;
import wso2/apk_keymanager_libs;
import wso2/apk_common_lib as commons;

configurable commons:DatasourceConfiguration datasourceConfiguration = ?;
configurable ThrottlingConfiguration throttleConfig = ?;
configurable TokenIssuerConfiguration & readonly issuerConfig = ?;
configurable KeyStores & readonly keyStores = {
    tls: {certFilePath: "/home/wso2apk/devportal/security/devportal.pem", keyFilePath: "/home/wso2apk/devportal/security/devportal.key"},
    signing: {keyFilePath: "/home/wso2apk/devportal/security/mg.pem"}
};
configurable SDKConfiguration & readonly sdkConfig = ?;
configurable K8sConfiguration k8sConfig = ?;
configurable ManagementServerConfiguration & readonly managementServerConfig = ?;

final postgresql:Client|sql:Error dbClient;
configurable int DEVPORTAL_PORT = 9443;
configurable commons:IDPConfiguration & readonly idpConfiguration = {
    publicKey: {keyFilePath: "/home/wso2apk/devportal/security/mg.pem"}
};
configurable KeyManagerConfigs[] keyManagerConfigs = [];
commons:DBBasedOrgResolver organizationResolver = new (datasourceConfiguration);
commons:JWTValidationInterceptor jwtValidationInterceptor = new (idpConfiguration, organizationResolver);
commons:RequestErrorInterceptor requestErrorInterceptor = new;
commons:ResponseErrorInterceptor responseErrorInterceptor = new;
apk_keymanager_libs:KeyManagerTypeInitializer keyManagerTypeInitializer = new ();
commons:UserRegistrationInterceptor userRegistrationInterceptor = new (datasourceConfiguration);
listener http:Listener ep0 = new (DEVPORTAL_PORT, secureSocket = {
    'key: {
        certFile: <string>keyStores.tls.certFilePath,
        keyFile: <string>keyStores.tls.keyFilePath
    }
}, interceptors = [jwtValidationInterceptor, userRegistrationInterceptor, requestErrorInterceptor, responseErrorInterceptor]);
configurable string keyManagerConntectorConfigurationFilePath = "/home/wso2apk/devportal/keymanager";
listener http:Listener keyManagerConnectorListener = new (9445);

function init() returns error? {
    log:printInfo("Starting APK Devportal Domain Service...");
    _ = check keyManagerTypeInitializer.initialize(keyManagerConntectorConfigurationFilePath);
    dbClient =
        new (host = datasourceConfiguration.host,
        username = datasourceConfiguration.username,
        password = datasourceConfiguration.password,
        database = datasourceConfiguration.databaseName,
        port = datasourceConfiguration.port,
        connectionPool = {maxOpenConnections: datasourceConfiguration.maxPoolSize}
    );
    if dbClient is error {
        return log:printError("Error while connecting to database");
    }
}

public isolated function getConnection() returns postgresql:Client|error {
    return dbClient;
}
