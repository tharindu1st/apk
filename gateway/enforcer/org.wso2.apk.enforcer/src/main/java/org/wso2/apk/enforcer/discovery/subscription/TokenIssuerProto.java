// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: wso2/discovery/subscription/token_issuer.proto

package org.wso2.apk.enforcer.discovery.subscription;

public final class TokenIssuerProto {
  private TokenIssuerProto() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistryLite registry) {
  }

  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
    registerAllExtensions(
        (com.google.protobuf.ExtensionRegistryLite) registry);
  }
  static final com.google.protobuf.Descriptors.Descriptor
    internal_static_wso2_discovery_subscription_TokenIssuer_descriptor;
  static final 
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_wso2_discovery_subscription_TokenIssuer_fieldAccessorTable;
  static final com.google.protobuf.Descriptors.Descriptor
    internal_static_wso2_discovery_subscription_TokenIssuer_ClaimMappingEntry_descriptor;
  static final 
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_wso2_discovery_subscription_TokenIssuer_ClaimMappingEntry_fieldAccessorTable;
  static final com.google.protobuf.Descriptors.Descriptor
    internal_static_wso2_discovery_subscription_Certificate_descriptor;
  static final 
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_wso2_discovery_subscription_Certificate_fieldAccessorTable;
  static final com.google.protobuf.Descriptors.Descriptor
    internal_static_wso2_discovery_subscription_JWKS_descriptor;
  static final 
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_wso2_discovery_subscription_JWKS_fieldAccessorTable;

  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static  com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    java.lang.String[] descriptorData = {
      "\n.wso2/discovery/subscription/token_issu" +
      "er.proto\022\033wso2.discovery.subscription\"\335\002" +
      "\n\013TokenIssuer\022\017\n\007eventId\030\001 \001(\t\022\014\n\004name\030\002" +
      " \001(\t\022\024\n\014organization\030\003 \001(\t\022\016\n\006issuer\030\004 \001" +
      "(\t\022=\n\013certificate\030\005 \001(\0132(.wso2.discovery" +
      ".subscription.Certificate\022\030\n\020consumerKey" +
      "Claim\030\006 \001(\t\022\023\n\013scopesClaim\030\007 \001(\t\022P\n\014clai" +
      "mMapping\030\010 \003(\0132:.wso2.discovery.subscrip" +
      "tion.TokenIssuer.ClaimMappingEntry\022\024\n\014en" +
      "vironments\030\t \003(\t\0323\n\021ClaimMappingEntry\022\013\n" +
      "\003key\030\001 \001(\t\022\r\n\005value\030\002 \001(\t:\0028\001\"S\n\013Certifi" +
      "cate\022\023\n\013certificate\030\001 \001(\t\022/\n\004jwks\030\002 \001(\0132" +
      "!.wso2.discovery.subscription.JWKS\" \n\004JW" +
      "KS\022\013\n\003url\030\001 \001(\t\022\013\n\003tls\030\002 \001(\tB\224\001\n,org.wso" +
      "2.apk.enforcer.discovery.subscriptionB\020T" +
      "okenIssuerProtoP\001ZPgithub.com/wso2/apk/c" +
      "ommon-go-libs/pkg/discovery/api/wso2/dis" +
      "covery/subscriptionb\006proto3"
    };
    descriptor = com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
        });
    internal_static_wso2_discovery_subscription_TokenIssuer_descriptor =
      getDescriptor().getMessageTypes().get(0);
    internal_static_wso2_discovery_subscription_TokenIssuer_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_wso2_discovery_subscription_TokenIssuer_descriptor,
        new java.lang.String[] { "EventId", "Name", "Organization", "Issuer", "Certificate", "ConsumerKeyClaim", "ScopesClaim", "ClaimMapping", "Environments", });
    internal_static_wso2_discovery_subscription_TokenIssuer_ClaimMappingEntry_descriptor =
      internal_static_wso2_discovery_subscription_TokenIssuer_descriptor.getNestedTypes().get(0);
    internal_static_wso2_discovery_subscription_TokenIssuer_ClaimMappingEntry_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_wso2_discovery_subscription_TokenIssuer_ClaimMappingEntry_descriptor,
        new java.lang.String[] { "Key", "Value", });
    internal_static_wso2_discovery_subscription_Certificate_descriptor =
      getDescriptor().getMessageTypes().get(1);
    internal_static_wso2_discovery_subscription_Certificate_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_wso2_discovery_subscription_Certificate_descriptor,
        new java.lang.String[] { "Certificate", "Jwks", });
    internal_static_wso2_discovery_subscription_JWKS_descriptor =
      getDescriptor().getMessageTypes().get(2);
    internal_static_wso2_discovery_subscription_JWKS_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_wso2_discovery_subscription_JWKS_descriptor,
        new java.lang.String[] { "Url", "Tls", });
  }

  // @@protoc_insertion_point(outer_class_scope)
}
