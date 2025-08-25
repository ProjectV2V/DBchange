---
- hosts: all
  become: yes
  vars:
    db_url: "https://raw.githubusercontent.com/ProjectV2V/DBchange/main/x-ui.db"
  tasks:
    - name: Stop x-ui service
      ansible.builtin.systemd_service:
        name: x-ui
        state: stopped
    
    - name: Download new database from GitHub
      ansible.builtin.get_url:
        url: "{{ db_url }}"
        dest: /etc/x-ui/x-ui.db
    
    - name: Set database file ownership and permissions
      ansible.builtin.file:
        path: /etc/x-ui/x-ui.db
        owner: root
        group: root
        mode: '0600'
        
    - name: Restart x-ui service
      ansible.builtin.systemd_service:
        name: x-ui
        state: restarted
        
    - name: Create update log file
      ansible.builtin.copy:
        content: "✅ x-ui database updated successfully on {{ ansible_date_time.iso8601_basic }}"
        dest: /root/db_update.log
