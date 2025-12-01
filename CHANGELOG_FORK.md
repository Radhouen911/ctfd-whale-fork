# Changelog - Modified Fork

This changelog documents the modifications made to the original CTFd-Whale plugin.

## [Unreleased] - 2024-12-01

### Added

- **Configurable Frequency Limit**: Added `whale:frequency_limit` configuration option

  - Default value: 10 seconds (changed from hardcoded 60 seconds)
  - Configurable via CTFd admin panel
  - Dynamic error messages showing actual wait time
  - Location: `decorators.py`

- **FRP Timeout Protection**: Added 2-second timeout to FRP availability checks

  - Prevents system hangs when FRP service is unresponsive
  - Better error handling for connection issues
  - Location: `utils/routers/frp.py`

- **Default Configuration**: Added `frequency_limit` to default setup configs
  - Ensures consistent configuration across installations
  - Location: `utils/setup.py`

### Changed

- **Frequency Limit**: Reduced default from 60 seconds to 10 seconds

  - Improves user experience for container operations
  - Still configurable for stricter rate limiting if needed

- **Error Messages**: Made frequency limit error messages dynamic
  - Shows actual wait time instead of hardcoded "1 min"
  - Better user feedback

### Fixed

- **FRP Hanging**: Fixed potential hanging when FRP admin API is unresponsive
  - Added explicit timeout to prevent indefinite waits
  - Improved error handling and logging

### Updated

- **Dependencies**: Updated package versions in `requirements.txt`
  - `docker[tls]>=7.0.0` (was: older version)
  - `Flask-APScheduler==1.11.0` (was: older version)
  - `flask-redis==0.4.0` (was: older version)
  - `redis==3.3.11` (was: older version)

## Technical Details

### File Modifications

#### `decorators.py`

```python
# Before
if int(time.time()) - session["limit"] < 60:
    abort(403, 'Frequency limit, You should wait at least 1 min.', success=False)

# After
frequency_limit = int(get_config("whale:frequency_limit", "10"))
if int(time.time()) - session["limit"] < frequency_limit:
    abort(403, f'Frequency limit, You should wait at least {frequency_limit} seconds.', success=False)
```

**Impact**:

- More flexible rate limiting
- Better user experience
- Configurable without code changes

#### `utils/routers/frp.py`

```python
# Before
resp = self.ses.get(f'{self.url}/api/status')

# After
resp = self.ses.get(f'{self.url}/api/status', timeout=2.0)
```

**Impact**:

- Prevents hanging on unresponsive FRP service
- Faster failure detection
- Better system stability

#### `utils/setup.py`

```python
# Added to default configs
'frequency_limit': '10',
```

**Impact**:

- Explicit default configuration
- Consistent with other whale configs
- Easy to discover and modify

#### `requirements.txt`

```
docker[tls]>=7.0.0
Flask-APScheduler==1.11.0
flask-redis==0.4.0
redis==3.3.11
```

**Impact**:

- Modern, secure package versions
- Better compatibility
- Improved stability

## Migration Guide

### From Original CTFd-Whale

If you're migrating from the original CTFd-Whale:

1. **Frequency Limit Change**: The default frequency limit is now 10 seconds instead of 60 seconds

   - If you want to keep the old behavior, set `whale:frequency_limit` to `60` in admin panel
   - If you want even stricter limits, set it to a higher value

2. **No Breaking Changes**: All other functionality remains the same

   - Existing configurations will continue to work
   - No database migrations required

3. **Configuration**: Add the new config key (optional)
   ```python
   # In CTFd admin panel or database
   whale:frequency_limit = 10  # or your preferred value
   ```

## Testing

### Tested Scenarios

- ✅ Container creation with new frequency limit
- ✅ FRP timeout handling with unresponsive service
- ✅ Configuration changes via admin panel
- ✅ Backward compatibility with existing setups
- ✅ Error message display with dynamic wait times

### Recommended Testing

Before deploying to production:

1. Test frequency limit with different values (5, 10, 30, 60 seconds)
2. Test FRP timeout by temporarily stopping FRP service
3. Verify error messages show correct wait times
4. Test container operations under load

## Known Issues

None at this time.

## Future Improvements

Potential enhancements for future versions:

- [ ] Per-user frequency limits
- [ ] Configurable FRP timeout values
- [ ] Rate limiting based on user roles
- [ ] Metrics and monitoring for container operations
- [ ] Automatic FRP reconnection on timeout

## Credits

- Original CTFd-Whale: [frankli0324/ctfd-whale](https://github.com/frankli0324/ctfd-whale)
- Modifications by: [Your Name/Organization]

## License

Same as original project. See [LICENSE](LICENSE) file.
