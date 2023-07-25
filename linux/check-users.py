import csv
import json

import numpy as np
import paramiko


def print_red(text):
    print(f"\033[91m{text}\033[00m")


def get_users_single_machine(
    server_addr: str,
    username: str,
    port: int = 22,
    machine_name: str = None,
):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    # Connecting to the host
    ssh.connect(hostname=server_addr, username=username, port=port)

    # Running the command
    stdin, stdout, stderr = ssh.exec_command(
        "awk -F: '($3>=1000 && $3<=60000 && $1 !~ /^#/ && $1 != \"\") {print $1}' /etc/passwd"
    )

    # Reading the output and removing the newline character at the end of each username
    usernames = [user.rstrip() for user in stdout.readlines()]

    # get machine hostname
    if machine_name is None:
        stdin, stdout, stderr = ssh.exec_command("hostname")
        machine_name = stdout.readlines()[0].rstrip()

    # Closing the connection
    ssh.close()

    return {machine_name: usernames}


def get_users_multiple_machines():
    data_dict = {}
    username = "markhuang"
    servers = []
    for addr, port in servers:
        print(f"Connecting to {addr}:{port}")
        try:
            data = get_users_single_machine(
                server_addr=addr,
                username=username,
                port=port,
            )
        except Exception as e:
            print_red(f"Error occurred when connecting to {addr}:{port}")
            print(e)
            continue
        data_dict.update(data)

    return data_dict


def reverse_dict(data_dict):
    reversed_dict = {}
    for key, value in data_dict.items():
        for v in value:
            if v not in reversed_dict:
                reversed_dict[v] = []
            reversed_dict[v].append(key)
    return reversed_dict


def main():
    machine_users_dict = get_users_multiple_machines()
    user_machine_dict = reverse_dict(machine_users_dict)

    all_machines = list(set([m for m in machine_users_dict.keys()]))
    all_users = list(set([u for u in user_machine_dict.keys()]))
    all_users.sort()
    all_machines.sort()

    num_machines = len(all_machines)
    num_users = len(all_users)

    print(f"Total number of machines: {num_machines}")
    print(f"Total number of users: {num_users}")

    # create a incidence matrix
    incidence_matrix = np.zeros((num_users, num_machines), dtype=int)
    for i, user in enumerate(all_users):
        for j, machine in enumerate(all_machines):
            if machine in user_machine_dict[user]:
                incidence_matrix[i, j] = 1

    # print the incidence matrix nicely
    # print(" " * 10, end="")
    # for machine in all_machines:
    #     print(f"{machine:20}", end="")
    # print()
    # for i, user in enumerate(all_users):
    #     print(f"{user:20}", end="")
    #     for j, machine in enumerate(all_machines):
    #         print(f"{incidence_matrix[i,j]:20}", end="")
    #     print()

    print(incidence_matrix)

    # save the matrix as csv
    with open("tmp_incidence_matrix.csv", "w") as f:
        writer = csv.writer(f)
        writer.writerow([""] + all_machines)
        for i, user in enumerate(all_users):
            writer.writerow([user] + incidence_matrix[i, :].tolist())

    with open("tmp_machine_users.json", "w") as f:
        json.dump(machine_users_dict, f, indent=2)

    with open("tmp_user_machine.json", "w") as f:
        json.dump(user_machine_dict, f, indent=2)


if __name__ == "__main__":
    main()
