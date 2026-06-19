# CHANGELOG

## Unreleased

### Added

- Added `docs/BCSaaS-Modernization-Status.md` as the main status document for the BC SaaS modernization effort.
- Added `docs/BCSaaS-Migration-Guide.md` with migration rules and review checklist.
- Added `docs/Modernization-Decision-Log.md` to document technical and functional migration decisions.

### Changed

- Updated `docs/src-page-modernization-review.md` to reflect merged PRs #17, #18 and #19.
- Modernized `Pag50006.Contadores.al` factboxes and reading history navigation.
- Modernized `Pag50027.Codigosderetencion.al` factboxes and `CurrPage.Editable` call.
- Documented unresolved `RunObject = Page 50002` in `Pag50027` instead of replacing it unsafely.

### Notes

- Documentation is now treated as part of each modernization PR.
- No PR should be considered complete without updating the relevant documentation when the modernization status or decision set changes.
