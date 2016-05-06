require "java_properties"

Dir.chdir(File.expand_path(File.dirname($0)))

env=ARGV[0]
property = JavaProperties::Properties.new("../../migration/conf/#{env}.conf")

url=property.[]("flyway.url").split("/")

system("java -Dfile.encoding=UTF-8 -jar ../schemaspy/schemaSpy_5.0.0.jar -t pgsql -host #{url[2]} -db #{url[3]} -u #{property.[]('flyway.user')} -s public -p #{ARGV[1]} -dp ../../migration/drivers/postgresql-9.4.1208.jar -charset utf-8 -o ../../build/schema")



