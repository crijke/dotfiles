const fs = require('fs')
const path = require('path')
const chalk = require('chalk')

if (process.argv.length !== 3 || process.argv[2] === 'help' || process.argv[2] === undefined) {
    console.log("work env switcher\n")
    console.log("usage:")
    console.log("workenv [personal|work] - activate workenv")
    console.log("workenv list - show active workenv")
    process.exit(1)
}

if (process.argv[2] === 'list') {
    const currentEnv = fs.readFileSync(path.join(process.env.HOME, '.workenv', 'env'))
    console.log(chalk.blue(`work env: ${currentEnv}`))
    process.exit(0)
}

// TODO check with fs.exists
if (!['personal', 'work'].includes(process.argv[2])) {
    console.log(`unknown env ${process.argv[2]}`)
    process.exit(1)
}

const env = process.argv[2]

const envDirectory = path.join(process.env.HOME, '.workenv/', env)
const NPMRC_HOME = path.join(process.env.HOME, ".npmrc");
const GITCONFIG_HOME = path.join(process.env.HOME, ".gitconfig");

fs.rmSync(NPMRC_HOME, {
    force: true,
})
fs.rmSync(GITCONFIG_HOME, {
    force: true,
})
fs.symlinkSync(path.join(envDirectory, ".npmrc"), NPMRC_HOME)
fs.symlinkSync(path.join(envDirectory, ".gitconfig"), GITCONFIG_HOME)

fs.writeFileSync(path.join(process.env.HOME, '.workenv', 'env'), `${env}\n`)

console.log(chalk.blue(`activated work env: ${env}`))

