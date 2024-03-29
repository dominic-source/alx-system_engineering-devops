#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

/**
 * infinite_while - an infinite while loop
 *
 * Return: 0
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - practice zombie process
 *
 * Return: 0
 */
int main(void)
{
	pid_t child;
	int i = 0;

	while (i < 5)
	{
		child = fork();
		if (child != 0)
			i++;
		else
			i = 5;
	}

	if (child == 0)
	{
		printf("Zombie process created, PID: %u\n", getpid());
		exit(0);
	}

	infinite_while();

	return (0);
}
