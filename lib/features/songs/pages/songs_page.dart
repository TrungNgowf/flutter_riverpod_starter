import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter/features/songs/providers/songs_provider.dart';
import 'package:flutter_riverpod_starter/models/song/song.dart';
import 'package:flutter_riverpod_starter/utils/utils.dart';
import 'package:flutter_riverpod_starter/widgets/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../state/songs_state.dart';

@RoutePage()
class SongsPage extends HookConsumerWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsState = ref.watch(songsProvider);
    final searchController = useTextEditingController();
    final searchFocusNode = useFocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Songs'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.search_normal_1),
            onPressed: () => searchFocusNode.requestFocus(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              focusNode: searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search songs...',
                prefixIcon: const Icon(Iconsax.search_normal_1),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          ref.read(songsProvider.notifier).search('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              onSubmitted: (value) {
                ref.read(songsProvider.notifier).search(value);
              },
            ),
          ),

          // Content
          Expanded(child: _buildContent(context, ref, songsState)),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    SongsState songsState,
  ) {
    // Using Dart 3 pattern matching with sealed class
    return switch (songsState) {
      SongsInitial() || SongsLoading() => Center(child: AppLoading.screen()),

      SongsError(:final error, :final searchQuery) => _ErrorView(
        message: error.message,
        onRetry: () =>
            ref.read(songsProvider.notifier).fetchSongs(search: searchQuery),
      ),

      SongsRefreshing(:final songs, :final searchQuery) ||
      SongsSuccess(:final songs, :final searchQuery) =>
        songs.isEmpty
            ? _EmptyView(
                searchQuery: searchQuery,
                onClearSearch: () =>
                    ref.read(songsProvider.notifier).search(''),
              )
            : RefreshIndicator(
                onRefresh: () => ref.read(songsProvider.notifier).refresh(),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return _SongListTile(
                      song: song,
                      onTap: () => _onSongTap(context, song),
                    );
                  },
                ),
              ),
    };
  }

  void _onSongTap(BuildContext context, Song song) {
    // Navigate to song detail or play song
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Playing: ${song.name}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Song list tile widget
class _SongListTile extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;

  const _SongListTile({required this.song, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _buildCover(context),
        title: Text(
          song.name,
          style: context.ext.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              song.artist,
              style: context.ext.textTheme.bodyMedium?.copyWith(
                color: context.ext.colors.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (song.genre != null) ...[
              const SizedBox(height: 2),
              Text(
                song.genre!,
                style: context.ext.textTheme.bodySmall?.copyWith(
                  color: context.ext.colors.outline,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        trailing: Icon(Iconsax.play_circle, color: context.ext.colors.primary),
      ),
    );
  }

  Widget _buildCover(BuildContext context) {
    if (song.cover != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          song.cover!,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _buildPlaceholder(context),
        ),
      );
    }
    return _buildPlaceholder(context);
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: context.ext.colors.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Iconsax.music, color: context.ext.colors.onPrimaryContainer),
    );
  }
}

/// Error view widget
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.warning_2, size: 64, color: context.ext.colors.error),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: context.ext.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: context.ext.textTheme.bodyMedium?.copyWith(
                color: context.ext.colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Iconsax.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty view widget
class _EmptyView extends StatelessWidget {
  final String? searchQuery;
  final VoidCallback onClearSearch;

  const _EmptyView({this.searchQuery, required this.onClearSearch});

  @override
  Widget build(BuildContext context) {
    final hasSearch = searchQuery != null && searchQuery!.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasSearch ? Iconsax.search_status : Iconsax.music_playlist,
              size: 64,
              color: context.ext.colors.outline,
            ),
            const SizedBox(height: 16),
            Text(
              hasSearch ? 'No songs found' : 'No songs yet',
              style: context.ext.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              hasSearch
                  ? 'Try searching with different keywords'
                  : 'Songs will appear here',
              style: context.ext.textTheme.bodyMedium?.copyWith(
                color: context.ext.colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (hasSearch) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: onClearSearch,
                icon: const Icon(Icons.clear),
                label: const Text('Clear Search'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
