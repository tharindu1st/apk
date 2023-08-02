// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: wso2/discovery/config/enforcer/config.proto

package org.wso2.apk.enforcer.discovery.config.enforcer;

public interface ConfigOrBuilder extends
    // @@protoc_insertion_point(interface_extends:wso2.discovery.config.enforcer.Config)
    com.google.protobuf.MessageOrBuilder {

  /**
   * <code>.wso2.discovery.config.enforcer.Security security = 1;</code>
   * @return Whether the security field is set.
   */
  boolean hasSecurity();
  /**
   * <code>.wso2.discovery.config.enforcer.Security security = 1;</code>
   * @return The security.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.Security getSecurity();
  /**
   * <code>.wso2.discovery.config.enforcer.Security security = 1;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.SecurityOrBuilder getSecurityOrBuilder();

  /**
   * <code>.wso2.discovery.config.enforcer.CertStore keystore = 2;</code>
   * @return Whether the keystore field is set.
   */
  boolean hasKeystore();
  /**
   * <code>.wso2.discovery.config.enforcer.CertStore keystore = 2;</code>
   * @return The keystore.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.CertStore getKeystore();
  /**
   * <code>.wso2.discovery.config.enforcer.CertStore keystore = 2;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.CertStoreOrBuilder getKeystoreOrBuilder();

  /**
   * <code>.wso2.discovery.config.enforcer.CertStore truststore = 3;</code>
   * @return Whether the truststore field is set.
   */
  boolean hasTruststore();
  /**
   * <code>.wso2.discovery.config.enforcer.CertStore truststore = 3;</code>
   * @return The truststore.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.CertStore getTruststore();
  /**
   * <code>.wso2.discovery.config.enforcer.CertStore truststore = 3;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.CertStoreOrBuilder getTruststoreOrBuilder();

  /**
   * <code>.wso2.discovery.config.enforcer.Service authService = 4;</code>
   * @return Whether the authService field is set.
   */
  boolean hasAuthService();
  /**
   * <code>.wso2.discovery.config.enforcer.Service authService = 4;</code>
   * @return The authService.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.Service getAuthService();
  /**
   * <code>.wso2.discovery.config.enforcer.Service authService = 4;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.ServiceOrBuilder getAuthServiceOrBuilder();

  /**
   * <code>.wso2.discovery.config.enforcer.JWTGenerator jwtGenerator = 5;</code>
   * @return Whether the jwtGenerator field is set.
   */
  boolean hasJwtGenerator();
  /**
   * <code>.wso2.discovery.config.enforcer.JWTGenerator jwtGenerator = 5;</code>
   * @return The jwtGenerator.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.JWTGenerator getJwtGenerator();
  /**
   * <code>.wso2.discovery.config.enforcer.JWTGenerator jwtGenerator = 5;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.JWTGeneratorOrBuilder getJwtGeneratorOrBuilder();

  /**
   * <code>.wso2.discovery.config.enforcer.Cache cache = 7;</code>
   * @return Whether the cache field is set.
   */
  boolean hasCache();
  /**
   * <code>.wso2.discovery.config.enforcer.Cache cache = 7;</code>
   * @return The cache.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.Cache getCache();
  /**
   * <code>.wso2.discovery.config.enforcer.Cache cache = 7;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.CacheOrBuilder getCacheOrBuilder();

  /**
   * <code>.wso2.discovery.config.enforcer.Analytics analytics = 8;</code>
   * @return Whether the analytics field is set.
   */
  boolean hasAnalytics();
  /**
   * <code>.wso2.discovery.config.enforcer.Analytics analytics = 8;</code>
   * @return The analytics.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.Analytics getAnalytics();
  /**
   * <code>.wso2.discovery.config.enforcer.Analytics analytics = 8;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.AnalyticsOrBuilder getAnalyticsOrBuilder();

  /**
   * <code>.wso2.discovery.config.enforcer.Management management = 9;</code>
   * @return Whether the management field is set.
   */
  boolean hasManagement();
  /**
   * <code>.wso2.discovery.config.enforcer.Management management = 9;</code>
   * @return The management.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.Management getManagement();
  /**
   * <code>.wso2.discovery.config.enforcer.Management management = 9;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.ManagementOrBuilder getManagementOrBuilder();

  /**
   * <code>.wso2.discovery.config.enforcer.RestServer restServer = 10;</code>
   * @return Whether the restServer field is set.
   */
  boolean hasRestServer();
  /**
   * <code>.wso2.discovery.config.enforcer.RestServer restServer = 10;</code>
   * @return The restServer.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.RestServer getRestServer();
  /**
   * <code>.wso2.discovery.config.enforcer.RestServer restServer = 10;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.RestServerOrBuilder getRestServerOrBuilder();

  /**
   * <code>.wso2.discovery.config.enforcer.Tracing tracing = 11;</code>
   * @return Whether the tracing field is set.
   */
  boolean hasTracing();
  /**
   * <code>.wso2.discovery.config.enforcer.Tracing tracing = 11;</code>
   * @return The tracing.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.Tracing getTracing();
  /**
   * <code>.wso2.discovery.config.enforcer.Tracing tracing = 11;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.TracingOrBuilder getTracingOrBuilder();

  /**
   * <code>.wso2.discovery.config.enforcer.Metrics metrics = 12;</code>
   * @return Whether the metrics field is set.
   */
  boolean hasMetrics();
  /**
   * <code>.wso2.discovery.config.enforcer.Metrics metrics = 12;</code>
   * @return The metrics.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.Metrics getMetrics();
  /**
   * <code>.wso2.discovery.config.enforcer.Metrics metrics = 12;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.MetricsOrBuilder getMetricsOrBuilder();

  /**
   * <code>repeated .wso2.discovery.config.enforcer.Filter filters = 13;</code>
   */
  java.util.List<org.wso2.apk.enforcer.discovery.config.enforcer.Filter> 
      getFiltersList();
  /**
   * <code>repeated .wso2.discovery.config.enforcer.Filter filters = 13;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.Filter getFilters(int index);
  /**
   * <code>repeated .wso2.discovery.config.enforcer.Filter filters = 13;</code>
   */
  int getFiltersCount();
  /**
   * <code>repeated .wso2.discovery.config.enforcer.Filter filters = 13;</code>
   */
  java.util.List<? extends org.wso2.apk.enforcer.discovery.config.enforcer.FilterOrBuilder> 
      getFiltersOrBuilderList();
  /**
   * <code>repeated .wso2.discovery.config.enforcer.Filter filters = 13;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.FilterOrBuilder getFiltersOrBuilder(
      int index);

  /**
   * <code>.wso2.discovery.config.enforcer.Soap soap = 14;</code>
   * @return Whether the soap field is set.
   */
  boolean hasSoap();
  /**
   * <code>.wso2.discovery.config.enforcer.Soap soap = 14;</code>
   * @return The soap.
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.Soap getSoap();
  /**
   * <code>.wso2.discovery.config.enforcer.Soap soap = 14;</code>
   */
  org.wso2.apk.enforcer.discovery.config.enforcer.SoapOrBuilder getSoapOrBuilder();
}
