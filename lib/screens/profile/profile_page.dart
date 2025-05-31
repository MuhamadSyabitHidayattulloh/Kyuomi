import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child:
                      Icon(LineIcons.user, size: 50, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                const Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SettingsSection(
            title: 'Tema',
            children: [
              SettingsTile(
                icon: LineIcons.sun,
                title: 'Mode Tema',
                subtitle: 'Terang',
                trailing: Icon(LineIcons.angleRight),
              ),
            ],
          ),
          const SettingsSection(
            title: 'Pengaturan Unduhan',
            children: [
              SettingsTile(
                icon: LineIcons.folderOpen,
                title: 'Lokasi Penyimpanan',
                subtitle: '/storage/downloads/kyuomi',
                trailing: Icon(LineIcons.angleRight),
              ),
              SettingsTile(
                icon: LineIcons.wifi,
                title: 'Unduh hanya dengan Wi-Fi',
                trailing: Switch(value: true, onChanged: null),
              ),
            ],
          ),
          const SettingsSection(
            title: 'Pengaturan Reader',
            children: [
              SettingsTile(
                icon: LineIcons.book,
                title: 'Layout Default',
                subtitle: 'Vertikal',
                trailing: Icon(LineIcons.angleRight),
              ),
              SettingsTile(
                icon: LineIcons.clock,
                title: 'Auto-scroll',
                trailing: Switch(value: false, onChanged: null),
              ),
            ],
          ),
          const SettingsSection(
            title: 'Aplikasi',
            children: [
              SettingsTile(
                icon: LineIcons.language,
                title: 'Bahasa',
                subtitle: 'Indonesia',
                trailing: Icon(LineIcons.angleRight),
              ),
              SettingsTile(
                icon: LineIcons.trash,
                title: 'Hapus Cache',
                subtitle: '234 MB',
                trailing: Icon(LineIcons.angleRight),
              ),
              SettingsTile(
                icon: LineIcons.infoCircle,
                title: 'Tentang Aplikasi',
                subtitle: 'Versi 1.0.0',
                trailing: Icon(LineIcons.angleRight),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FilledButton.icon(
              onPressed: () {
                // TODO: Implement logout
              },
              icon: const Icon(LineIcons.alternateSignOut),
              label: const Text('Keluar'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: () {
        // TODO: Implement settings navigation
      },
    );
  }
}
