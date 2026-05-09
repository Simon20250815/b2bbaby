<template>
    <private-view smallHeader title="Blog Management">
        <template #title>
            <div>
                <h1 class="font-semibold text-lg text-slate-900">{{ 'Blog Management' }}</h1>
                <div class="text-sm">Manage blog posts, edit content, and control publication status.</div>
            </div>
        </template>
        <template #actions>
            <v-button
                v-tooltip.bottom="Add New Blog"
                rounded
                icon
                :disabled="false"
                to="/seo-settings/content/blogs/create"
            >
                <v-icon name="add"></v-icon>
            </v-button>
        </template>
        <template #navigation>
            <navigator />
        </template>
        <div class="py-6 px-7.5">
            <div class="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
                <div class="p-4 border-b border-slate-100 flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <div class="relative">
                            <v-icon name="search" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                            <input 
                                v-model="searchQuery" 
                                type="text" 
                                placeholder="Search blogs..." 
                                class="pl-10 pr-4 py-2 border border-slate-200 rounded-lg text-sm w-64 focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <select 
                            v-model="filterStatus" 
                            class="px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:border-primary bg-white"
                        >
                            <option value="all">All Status</option>
                            <option value="published">Published</option>
                            <option value="draft">Draft</option>
                        </select>
                    </div>
                    <div class="flex items-center gap-2">
                        <span class="text-sm text-slate-500">Total: {{ blogs.length }}</span>
                    </div>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                            <tr class="bg-slate-50">
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Cover</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Title</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Category</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Date</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Status</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100">
                            <tr v-for="blog in filteredBlogs" :key="blog.id" class="hover:bg-slate-50 transition-colors">
                                <td class="px-4 py-4">
                                    <img 
                                        :src="blog.cover_image || 'https://via.placeholder.com/64'" 
                                        :alt="blog.title"
                                        class="w-14 h-14 rounded-lg object-cover"
                                    />
                                </td>
                                <td class="px-4 py-4">
                                    <div class="font-medium text-slate-900">{{ blog.title }}</div>
                                    <div class="text-sm text-slate-500">{{ blog.slug }}</div>
                                </td>
                                <td class="px-4 py-4">
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-50 text-blue-700">
                                        {{ blog.category }}
                                    </span>
                                </td>
                                <td class="px-4 py-4 text-slate-600">{{ formatDate(blog.date_published) }}</td>
                                <td class="px-4 py-4">
                                    <span 
                                        :class="[
                                            'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium',
                                            blog.status === 'published' ? 'bg-green-50 text-green-700' : 'bg-yellow-50 text-yellow-700'
                                        ]"
                                    >
                                        <span class="w-1.5 h-1.5 rounded-full mr-1.5" :class="blog.status === 'published' ? 'bg-green-500' : 'bg-yellow-500'"></span>
                                        {{ blog.status }}
                                    </span>
                                </td>
                                <td class="px-4 py-4">
                                    <div class="flex items-center gap-2">
                                        <v-button 
                                            size="small" 
                                            secondary 
                                            :to="`/seo-settings/content/blogs/${blog.id}/edit`"
                                        >
                                            <v-icon name="edit" class="w-4 h-4 mr-1" />
                                            Edit
                                        </v-button>
                                        <v-button 
                                            size="small" 
                                            danger 
                                            @click="deleteBlog(blog)"
                                        >
                                            <v-icon name="delete" class="w-4 h-4 mr-1" />
                                            Delete
                                        </v-button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div v-if="filteredBlogs.length === 0" class="py-12 text-center">
                    <v-icon name="inbox" class="w-12 h-12 text-slate-300 mx-auto mb-4" />
                    <p class="text-slate-500">No blogs found</p>
                </div>
            </div>
        </div>
        <v-dialog v-model="showDeleteConfirm">
            <v-card class="rounded-xl">
                <v-card-title>Confirm Delete</v-card-title>
                <v-card-text>
                    Are you sure you want to delete "{{ deletingBlog?.title }}" ?
                </v-card-text>
                <v-card-actions>
                    <v-button secondary @click="showDeleteConfirm = false">Cancel</v-button>
                    <v-button danger @click="confirmDelete">Delete</v-button>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </private-view>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useApi, useStores } from '@directus/extensions-sdk';
import Navigator from '../../components/navigator/index.vue';

const api = useApi();
const { useNotificationsStore } = useStores();
const notify = useNotificationsStore();

const searchQuery = ref('');
const filterStatus = ref('all');
const blogs = ref([]);
const showDeleteConfirm = ref(false);
const deletingBlog = ref(null);

const filteredBlogs = computed(() => {
    let result = blogs.value;
    if (searchQuery.value) {
        const query = searchQuery.value.toLowerCase();
        result = result.filter(b => 
            b.title.toLowerCase().includes(query) || 
            b.slug.toLowerCase().includes(query) ||
            b.category.toLowerCase().includes(query)
        );
    }
    if (filterStatus.value !== 'all') {
        result = result.filter(b => b.status === filterStatus.value);
    }
    return result;
});

function formatDate(dateStr: string) {
    if (!dateStr) return 'N/A';
    const date = new Date(dateStr);
    return date.toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' });
}

async function loadBlogs() {
    try {
        const response = await api.get('/items/blogs', {
            params: {
                fields: ['id', 'title', 'slug', 'category', 'date_published', 'cover_image', 'status'],
                limit: -1,
                sort: [{ date_published: 'desc' }]
            }
        });
        blogs.value = response.data.data.map(b => ({
            ...b,
            cover_image: b.cover_image ? `${import.meta.env.DIRECTUS_URL || 'http://localhost:8055'}/assets/${b.cover_image.id}` : null
        }));
    } catch (error) {
        console.error('Failed to load blogs:', error);
        notify.add({ title: 'Error loading blogs', type: 'error' });
    }
}

function deleteBlog(blog) {
    deletingBlog.value = blog;
    showDeleteConfirm.value = true;
}

async function confirmDelete() {
    try {
        await api.delete(`/items/blogs/${deletingBlog.value.id}`);
        blogs.value = blogs.value.filter(b => b.id !== deletingBlog.value.id);
        notify.add({ title: 'Blog deleted successfully' });
    } catch (error) {
        notify.add({ title: 'Error deleting blog', type: 'error' });
    }
    showDeleteConfirm.value = false;
    deletingBlog.value = null;
}

loadBlogs();
</script>