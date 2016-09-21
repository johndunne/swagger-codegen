package io.swagger.codegen.languages;

import io.swagger.codegen.*;
import io.swagger.models.properties.ArrayProperty;
import io.swagger.models.properties.MapProperty;
import io.swagger.models.properties.Property;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.*;
import org.apache.commons.lang3.StringUtils;

public class GoServerCodegen extends DefaultCodegen implements CodegenConfig {

    private static final Logger LOGGER = LoggerFactory.getLogger(GoServerCodegen.class);

    protected String apiVersion = "1.0.0";
    protected int serverPort = 8080;
    protected String projectName = "swagger-server";
    protected String apiPath = "src/quickflickserver/controllers";
    protected String projectRoot = "src/quickflickserver";

    protected String PROJECT_NAME = "lah";
    protected String DB_DIALECT = "db_dialect";
    protected String dbDialect = "mysql";
    protected String DB_BACKEND = "db_backend";
    protected String dbBackend = "gorm";
    protected String DB_USER = "db_user";
    protected String dbUser = "user";
    protected String DB_PASSWORD = "db_password";
    protected String dbPassword = "password";
    protected String DB_NAME = "db_name";
    protected String dbName = "dbname";
    protected String USE_OAUTH = "use_oauth";
    protected boolean useOauth = true;
    protected String OAUTH_SECRET_KEY = "oauth_secret_key";
    protected String oauthSecretKey = "SECRETNESS_PLEASE";
    protected String LISTEN_PORT = "listen_port";
    protected int listenPort = 8961;
    protected String INCLUDE_PLACEHOLDER_HANDLERS = "include_placeholder_handlers";
    protected boolean includePlaceHolderHandlers = false;
    protected String HANDLERS_PACKAGE_NAME = "handlers_package_name";
    protected String handlersPackageName = "handlers";


    public GoServerCodegen() {
        super();

        // set the output folder here
        outputFolder = "generated-code/go";

        /*
         * Models.  You can write model files using the modelTemplateFiles map.
         * if you want to create one template for file, you can do so here.
         * for multiple files for model, just put another entry in the `modelTemplateFiles` with
         * a different extension
         */
        modelPackage = "src/quickflickserver/models";
        apiPackage = "src/quickflickserver/controllers";

        modelTemplateFiles.clear();
        modelTemplateFiles.put("models.mustache", ".go");

        /*
         * Api classes.  You can write classes for each Api file with the apiTemplateFiles map.
         * as with models, add multiple entries with different extensions for multiple files per
         * class
         */
        apiTemplateFiles.put(
                "controller.mustache",   // the template to use
                ".go");       // the extension for each file to write

        /*
         * Template Location.  This is the location which templates will be read from.  The generator
         * will use the resource stream to attempt to read the templates.
         */
        embeddedTemplateDir = templateDir = "go-server";

        /*
         * Reserved words.  Override this with reserved words specific to your language
         */
        setReservedWordsLowerCase(
            Arrays.asList(
                "break", "default", "func", "interface", "select",
                "case", "defer", "go", "map", "struct",
                "chan", "else", "goto", "package", "switch",
                "const", "fallthrough", "if", "range", "type",
                "continue", "for", "import", "return", "var", "error", "ApiResponse")
                // Added "error" as it's used so frequently that it may as well be a keyword
        );

        defaultIncludes = new HashSet<String>(
                Arrays.asList(
                    "map",
                    "array")
                );

        languageSpecificPrimitives = new HashSet<String>(
            Arrays.asList(
                "string",
                "bool",
                "uint",
                "uint32",
                "uint64",
                "int",
                "int32",
                "int64",
                "float32",
                "float64",
                "complex64",
                "complex128",
                "rune",
                "byte")
            );

        instantiationTypes.clear();
        /*instantiationTypes.put("array", "GoArray");
        instantiationTypes.put("map", "GoMap");*/

        typeMapping.clear();
        typeMapping.put("integer", "int32");
        typeMapping.put("long", "int64");
        typeMapping.put("number", "float32");
        typeMapping.put("float", "float32");
        typeMapping.put("double", "float64");
        typeMapping.put("boolean", "bool");
        typeMapping.put("string", "string");
        typeMapping.put("date", "time.Time");
        typeMapping.put("DateTime", "time.Time");
        typeMapping.put("password", "string");
        typeMapping.put("File", "*os.File");
        typeMapping.put("file", "*os.File");
        // map binary to string as a workaround
        // the correct solution is to use []byte
        typeMapping.put("binary", "string");
        typeMapping.put("ByteArray", "string");

        importMapping = new HashMap<String, String>();
        importMapping.put("time.Time", "time");
        importMapping.put("*os.File", "os");
        importMapping.put("os", "io/ioutil");

        cliOptions.clear();
        cliOptions.add(new CliOption(CodegenConstants.PACKAGE_NAME, "Go package name (convention: lowercase).")
                .defaultValue("swagger"));
        // Added for support of custom DB and oauth credentials
        cliOptions.add(new CliOption(PROJECT_NAME, "Project name in Xcode"));
        cliOptions.add(new CliOption(DB_BACKEND, "Which db should be used for the backend. gorm is currently available."));
        cliOptions.add(new CliOption(DB_USER, "The database username."));
        cliOptions.add(new CliOption(DB_PASSWORD, "The database password."));
        cliOptions.add(new CliOption(DB_NAME, "The database name to connect to."));
        cliOptions.add(new CliOption(USE_OAUTH, "Use oauth.com for authorisation and authentcaiton?"));
        cliOptions.add(new CliOption(OAUTH_SECRET_KEY, "OAuth secret key"));
        /**
         * Additional Properties.  These values can be passed to the templates and
         * are available in models, apis, and supporting files
         */
        additionalProperties.put("apiVersion", apiVersion);
        additionalProperties.put("serverPort", serverPort);
        additionalProperties.put("apiPath", apiPath);
        /*
         * Supporting Files.  You can write single files for the generator with the
         * entire object tree available.  If the input file has a suffix of `.mustache
         * it will be processed by the template engine.  Otherwise, it will be copied
         */
        supportingFiles.add(new SupportingFile("swagger.mustache",
                        "api",
                        "swagger.yaml")
        );
        //supportingFiles.add(new SupportingFile("main.mustache", "src/quickflickservermain", "main.go"));
        supportingFiles.add(new SupportingFile("routers.mustache", projectRoot, "routers.go"));
        supportingFiles.add(new SupportingFile("gorm_models.mustache", projectRoot, "gorm_models.go"));
        supportingFiles.add(new SupportingFile("logger.mustache", projectRoot, "logger.go"));
        supportingFiles.add(new SupportingFile("app.mustache", projectRoot, "app.yaml"));
        supportingFiles.add(new SupportingFile("json_object.mustache", projectRoot+"/helpers", "json_operations.go"));
        writeOptional(outputFolder, new SupportingFile("README.mustache", projectRoot, "README.md"));
    }

    @Override
    public String apiPackage() {
        return apiPath;
    }

    /**
     * Configures the type of generator.
     *
     * @return the CodegenType for this generator
     * @see io.swagger.codegen.CodegenType
     */
    @Override
    public CodegenType getTag() {
        return CodegenType.SERVER;
    }

    /**
     * Configures a friendly name for the generator.  This will be used by the generator
     * to select the library with the -l flag.
     *
     * @return the friendly name for the generator
     */
    @Override
    public String getName() {
        return "go-server";
    }

    /**
     * Returns human-friendly help for the generator.  Provide the consumer with help
     * tips, parameters here
     *
     * @return A string value for the help message
     */
    @Override
    public String getHelp() {
        return "Generates a Go server library using the swagger-tools project.  By default, " +
                "it will also generate service classes--which you can disable with the `-Dnoservice` environment variable.";
    }

    @Override
    public String toApiName(String name) {
        if (name.length() == 0) {
            return "DefaultController";
        }
        return initialCaps(name);
    }

    /**
     * Escapes a reserved word as defined in the `reservedWords` array. Handle escaping
     * those terms here.  This logic is only called if a variable matches the reseved words
     *
     * @return the escaped term
     */
    @Override
    public String escapeReservedWord(String name) {
        return "_" + name;  // add an underscore to the name
    }

    /**
     * Location to write api files.  You can use the apiPackage() as defined when the class is
     * instantiated
     */
    @Override
    public String apiFileFolder() {
        return outputFolder + File.separator + apiPackage().replace('.', File.separatorChar);
    }

    @Override
    public String toModelName(String name) {
        // camelize the model name
        // phone_number => PhoneNumber
        return camelize(toModelFilename(name));
    }

    @Override
    public String toOperationId(String operationId) {
        // method name cannot use reserved keyword, e.g. return
        if (isReservedWord(operationId)) {
            LOGGER.warn(operationId + " (reserved word) cannot be used as method name. Renamed to " + camelize(sanitizeName("call_" + operationId)));
            operationId = "call_" + operationId;
        }

        return camelize(operationId);
    }

    @Override
    public String toModelFilename(String name) {
        if (!StringUtils.isEmpty(modelNamePrefix)) {
            name = modelNamePrefix + "_" + name;
        }

        if (!StringUtils.isEmpty(modelNameSuffix)) {
            name = name + "_" + modelNameSuffix;
        }

        name = sanitizeName(name);

        // model name cannot use reserved keyword, e.g. return
        if (isReservedWord(name)) {
            LOGGER.warn(name + " (reserved word) cannot be used as model name. Renamed to " + camelize("model_" + name));
            name = "model_" + name; // e.g. return => ModelReturn (after camelize)
        }

        return underscore(name);
    }

    @Override
    public String toApiFilename(String name) {
        // replace - with _ e.g. created-at => created_at
        name = name.replaceAll("-", "_"); // FIXME: a parameter should not be assigned. Also declare the methods parameters as 'final'.

        // e.g. PetApi.go => pet_api.go
        return underscore(name);
    }

    @Override
    public String getTypeDeclaration(Property p) {
        if(p instanceof ArrayProperty) {
            ArrayProperty ap = (ArrayProperty) p;
            Property inner = ap.getItems();
            return "[]" + getTypeDeclaration(inner);
        }
        else if (p instanceof MapProperty) {
            MapProperty mp = (MapProperty) p;
            Property inner = mp.getAdditionalProperties();

            return getSwaggerType(p) + "[string]" + getTypeDeclaration(inner);
        }
        //return super.getTypeDeclaration(p);

        // Not using the supertype invocation, because we want to UpperCamelize
        // the type.
        String swaggerType = getSwaggerType(p);
        if (typeMapping.containsKey(swaggerType)) {
            return typeMapping.get(swaggerType);
        }

        if(typeMapping.containsValue(swaggerType)) {
            return swaggerType;
        }

        if(languageSpecificPrimitives.contains(swaggerType)) {
            return swaggerType;
        }

        return toModelName(swaggerType);
    }

    @Override
    public String getSwaggerType(Property p) {
        String swaggerType = super.getSwaggerType(p);
        String type = null;
        if(typeMapping.containsKey(swaggerType)) {
            type = typeMapping.get(swaggerType);
            if(languageSpecificPrimitives.contains(type))
                return (type);
        }
        else
            type = swaggerType;
        return type;
    }

    @Override
    public String escapeQuotationMark(String input) {
        // remove " to avoid code injection
        return input.replace("\"", "");
    }

    @Override
    public String escapeUnsafeCharacters(String input) {
        return input.replace("*/", "*_/").replace("/*", "/_*");
    }

    public Map<String, Object> postProcessOperations(Map<String, Object> objs) {
        @SuppressWarnings("unchecked")
        Map<String, Object> objectMap = (Map<String, Object>) objs.get("operations");
        @SuppressWarnings("unchecked")
        List<CodegenOperation> operations = (List<CodegenOperation>) objectMap.get("operation");
        for (CodegenOperation operation : operations) {
            // http method verb conversion (e.g. PUT => Put)
            // http method verb conversion (e.g. PUT => Put)
            operation.httpMethod = camelize(operation.httpMethod.toLowerCase());
        }

        // remove model imports to avoid error
        List<Map<String, String>> imports = (List<Map<String, String>>) objs.get("imports");
        if (imports == null)
            return objs;

        Iterator<Map<String, String>> iterator = imports.iterator();
        while (iterator.hasNext()) {
            String _import = iterator.next().get("import");
            if (_import.startsWith(apiPackage()))
                iterator.remove();
        }
        // if the return type is not primitive, import encoding/json
        for (CodegenOperation operation : operations) {
            if(operation.returnBaseType != null && needToImport(operation.returnBaseType)) {
                imports.add(createMapping("import", "encoding/json"));
                break; //just need to import once
            }
        }

        // this will only import "strings" "fmt" if there are items in pathParams
        for (CodegenOperation operation : operations) {
            if(operation.pathParams != null && operation.pathParams.size() > 0) {
                imports.add(createMapping("import", "fmt"));
                imports.add(createMapping("import", "strings"));
                break; //just need to import once
            }
        }


        // recursively add import for mapping one type to multiple imports
        List<Map<String, String>> recursiveImports = (List<Map<String, String>>) objs.get("imports");
        if (recursiveImports == null)
            return objs;

        ListIterator<Map<String, String>> listIterator = imports.listIterator();
        while (listIterator.hasNext()) {
            String _import = listIterator.next().get("import");
            // if the import package happens to be found in the importMapping (key)
            // add the corresponding import package to the list
            if (importMapping.containsKey(_import)) {
                listIterator.add(createMapping("import", importMapping.get(_import)));
            }
        }

        return objs;
    }

    @Override
    public void processOpts() {
        super.processOpts();

        if( !additionalProperties.containsKey(DB_BACKEND) ){
            additionalProperties.put(DB_BACKEND, this.dbBackend);
        }
        if( !additionalProperties.containsKey(DB_DIALECT) ){
            additionalProperties.put(DB_DIALECT, this.dbDialect);
        }
        if( !additionalProperties.containsKey(DB_USER) ){
            additionalProperties.put(DB_USER, this.dbUser);
        }
        if( !additionalProperties.containsKey(DB_PASSWORD) ){
            additionalProperties.put(DB_PASSWORD, this.dbPassword);
        }
        if( !additionalProperties.containsKey(DB_NAME) ){
            additionalProperties.put(DB_NAME, this.dbName);
        }
        if( !additionalProperties.containsKey(OAUTH_SECRET_KEY) ){
            additionalProperties.put(OAUTH_SECRET_KEY, this.oauthSecretKey);
        }
        if( !additionalProperties.containsKey(USE_OAUTH) ){
            additionalProperties.put(USE_OAUTH, this.useOauth);
        }
        if( !additionalProperties.containsKey(LISTEN_PORT) ){
            additionalProperties.put(LISTEN_PORT, this.listenPort);
        }
        if( !additionalProperties.containsKey(INCLUDE_PLACEHOLDER_HANDLERS) ){
            additionalProperties.put(INCLUDE_PLACEHOLDER_HANDLERS, this.includePlaceHolderHandlers);
        }
        if( !additionalProperties.containsKey(HANDLERS_PACKAGE_NAME) ){
            additionalProperties.put(HANDLERS_PACKAGE_NAME, this.handlersPackageName);
        }

        supportingFiles.add(new SupportingFile("gorm.mustache", projectRoot + "/db", "gorm.go"));
    }

    public Map<String, String> createMapping(String key, String value){
        Map<String, String> customImport = new HashMap<String, String>();
        customImport.put(key, value);

        return customImport;
    }

}
