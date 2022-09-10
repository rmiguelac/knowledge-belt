# Postgres


## Table of Contents

* [Check timescale plugin license](#check-timescale-plugin-license)  
* [Check timescale (and others) plugin version](#check-timescale--and-others--plugin-version)


## Check timescale plugin license
```sql
show timescaledb.license;
```

## Check timescale (and others) plugin version

```sql
select * from pg_extension;
```

or

```sql
\dx
```

There is also a table with more details such as `installed` and `available` versions:

```sql
select * from pg_available_extensions;
```