import ballerinax/postgresql;
import ballerina/sql;
import ballerina/log;

final postgresql:Client|sql:Error dbClient;
public class DBBasedOrgResolver {
    *OrganizationResolver;
    public function init(DatasourceConfiguration datasourceConfiguration) {
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
        
    
    public isolated function retrieveOrganizationFromIDPClaimValue(string organizationClaim) returns Organization? {
        postgresql:Client | sql:Error dbClient1  = self.getConnection();
            if dbClient1 is sql:Error {
                log:printInfo("db error", dbClient1);
                return;
            } else {
            sql:ParameterizedQuery query = `SELECT ORGANIZATION.UUID as uuid, NAME as name, 
                display_name as displayName, claim_value as organizationClaimValue, 
                status as enabled FROM ORGANIZATION,ORGANIZATION_CLAIM_MAPPING 
                where claim_value =${organizationClaim}`;
            Organization? | sql:Error result =  dbClient1->queryRow(query);
            if result is sql:NoRowsError {
                log:printInfo("no rows found"+ organizationClaim);
                return;
            } else if result is Organization {
                return result;
            } else { 
                log:printInfo("Error while getting organization"+ organizationClaim);
                return;
            }
        }
    }

    public isolated function retrieveOrganizationByName(string organizationName) returns Organization? {
        postgresql:Client | sql:Error dbClient1  = self.getConnection();
            if dbClient1 is sql:Error {
                return;
            } else {
            sql:ParameterizedQuery query = `SELECT ORGANIZATION.UUID as uuid, NAME as name, 
                display_name as displayName, claim_value as organizationClaimValue, 
                status as enabled FROM ORGANIZATION,ORGANIZATION_CLAIM_MAPPING 
                where ORGANIZATION.uuid = ORGANIZATION_CLAIM_MAPPING.uuid and ORGANIZATION.name=${organizationName}`;
            Organization? | sql:Error result =  dbClient1->queryRow(query);
            if result is sql:NoRowsError {
                log:printInfo("no rows found "+ organizationName);
                return;
            } else if result is Organization {
                return result;
            } else { 
                log:printInfo("Error while getting organization "+ organizationName);
                return;
            }
        }
    }

   public isolated function getConnection() returns postgresql:Client | sql:Error {
        return dbClient;  
    }


    
}
