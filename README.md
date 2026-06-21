


### Start the psql tool
docker compose exec ssi-db psql -U admin -d bank

## 2. Setup database

Run in any terminal:

```sql
\i sql/01_setup.sql
```

## 3. Demo 1: REPEATABLE READ allows write skew

Terminal A:

```sql
\i sql/02_repeatable_read_session_a.sql
```

Terminal B:

```sql
\i sql/03_repeatable_read_session_b.sql
```

Terminal A:

```sql
COMMIT;
```

Terminal B:

```sql
COMMIT;
```

Check final state:

```sql
\i sql/07_final_state.sql
```

Expected result: both doctors are off call. The business rule is broken.

## 4. Reset data

```sql
\i sql/08_reset.sql
```

## 5. Demo 2: SERIALIZABLE prevents write skew

Terminal A:

```sql
\i sql/04_serializable_session_a.sql
```

Terminal B:

```sql
\i sql/05_serializable_session_b.sql
```

Terminal A:

```sql
COMMIT;
```

Terminal B:

```sql
COMMIT;
```

Expected result: one transaction should fail with a serialization error similar to:

```text
ERROR: could not serialize access due to read/write dependencies among transactions
```

Check final state:

```sql
\i sql/07_final_state.sql
```

Expected result: one doctor remains on call. The business rule is preserved.

## 6. Optional monitoring

While both transactions are still open, run this in a third terminal:

```sql
\i sql/06_monitoring.sql
```

Use screenshots from:

- REPEATABLE READ final broken state
- SERIALIZABLE serialization error
- SERIALIZABLE final valid state
- `pg_stat_activity`
- `pg_locks`

